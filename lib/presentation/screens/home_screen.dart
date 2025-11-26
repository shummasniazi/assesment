import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/color_constants.dart';
import '../../core/constants/responsive_constants.dart';
import '../../core/constants/string_constants.dart';
import '../../shared/widgets/buttons/app_button.dart';
import '../../shared/widgets/theme_toggle_switch.dart';
import '../blocs/random_image/random_image_bloc.dart';
import '../blocs/random_image/random_image_event.dart';
import '../blocs/random_image/random_image_state.dart';
import '../widgets/random_image_display.dart';

/// Home screen that displays the random image app
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    debugPrint(StringConstants.homeScreenInitStateFetchingInitialImage);
    // Fetch initial image
    context.read<RandomImageBloc>().add(const FetchRandomImage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RandomImageBloc, RandomImageState>(
        builder: (context, state) {
          debugPrint('${StringConstants.homeScreenBlocBuilderState} ${state.runtimeType}');
          return AnimatedContainer(
            duration: ResponsiveConstants.animationDuration500,
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: _getBackgroundColor(state),
            ),
            child: SafeArea(
              child: Stack(
                children: [
                  Padding(
                    padding: ResponsiveConstants.screenPadding,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        // Image display area
                        Expanded(
                          flex: 3,
                          child: RandomImageDisplay(
                            state: state,
                            onRetry: state is RandomImageError
                                ? () => context.read<RandomImageBloc>().add(const FetchRandomImage())
                                : null,
                          ),
                        ),
                        const Spacer(),
                        // Button area
                        AppButton.primary(
                          text: StringConstants.another,
                          isLoading: state is RandomImageLoading,
                          onPressed: state is RandomImageLoading
                              ? null
                              : () {
                                  debugPrint(StringConstants.homeScreenButtonPressedFetchingNewImage);
                                  context.read<RandomImageBloc>().add(const FetchRandomImage());
                                },
                          width: double.infinity,
                          semanticLabel: state is RandomImageLoading
                          ? StringConstants.loadingNewImage
                          : StringConstants.loadAnotherRandomImage,
                      tooltip: StringConstants.tapToFetchANewRandomImageFromTheServer,
                        ),
                      ],
                    ),
                  ),
                  // Theme toggle in top right corner
                  Positioned(
                    top: ResponsiveConstants.spacing16,
                    right: ResponsiveConstants.spacing16,
                    child: const ThemeToggleSwitch(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// Gets the background color based on the current state
  Color _getBackgroundColor(RandomImageState state) {
    if (state is RandomImageLoaded && state.dominantColor != null) {
      return Color(state.dominantColor!);
    }

    // Default colors based on theme
    return Theme.of(context).colorScheme.background;
  }
}
