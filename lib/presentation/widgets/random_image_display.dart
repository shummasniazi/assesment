import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../core/constants/color_constants.dart';
import '../../core/constants/responsive_constants.dart';
import '../../core/constants/string_constants.dart';
import '../blocs/random_image/random_image_state.dart';

/// Widget to display the random image with loading and error states
class RandomImageDisplay extends StatefulWidget {
  final RandomImageState state;
  final VoidCallback? onRetry;

  const RandomImageDisplay({
    super.key,
    required this.state,
    this.onRetry,
  });

  @override
  State<RandomImageDisplay> createState() => _RandomImageDisplayState();
}

class _RandomImageDisplayState extends State<RandomImageDisplay>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  // WebView loading state
  bool _isWebViewLoading = true;
  double _loadingProgress = 0.0;

  // Persist WebViewController to prevent recreation on every build
  WebViewController? _webViewController;
  String? _currentImageUrl;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: ResponsiveConstants.animationDuration500,
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: ResponsiveConstants.opacity0,
      end: ResponsiveConstants.opacity100,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    // Start fade in when widget is first created
    _fadeController.forward();
  }

  @override
  void didUpdateWidget(RandomImageDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Restart animation when state changes
    if (oldWidget.state != widget.state) {
      _fadeController.reset();
      _fadeController.forward();
    }

    // Check if we need to update the WebView for a new image
    if (widget.state is RandomImageLoaded) {
      final newImageUrl = (widget.state as RandomImageLoaded).randomImage.url;
      if (_currentImageUrl != newImageUrl) {
        _currentImageUrl = newImageUrl;
        _initializeWebViewController(newImageUrl);
      }
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }


  void _initializeWebViewController(String imageUrl) {
    debugPrint('${StringConstants.initializingWebViewControllerForImage} $imageUrl');

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..loadHtmlString(_buildImageHtml(imageUrl))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            if (mounted) {
              setState(() {
                _loadingProgress = progress / 100.0;
              });
              debugPrint('${StringConstants.webViewLoadingProgress} $progress%');
            }
          },
          onPageStarted: (url) {
            if (mounted) {
              setState(() {
                _isWebViewLoading = true;
                _loadingProgress = 0.0;
              });
              debugPrint('${StringConstants.webViewStartedLoading} $url');
            }
          },
          onPageFinished: (url) async {
            debugPrint('${StringConstants.webViewPageFinishedLoading} $url');

            // Since console shows "Image loaded successfully", use a simple timeout
            // The WebView JavaScript environment seems unreliable for detection
            if (mounted) {
              await Future.delayed(const Duration(milliseconds: 1200));
              setState(() => _isWebViewLoading = false);
              debugPrint(StringConstants.webViewLoadingCompletedShowingImage);
            }
          },
          onWebResourceError: (error) {
            debugPrint('${StringConstants.webViewResourceError} ${error.description}');
            if (mounted) {
              setState(() => _isWebViewLoading = false);
            }
          },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      image: true,
      label: _getSemanticLabel(),
      hint: _getSemanticHint(),
      child: AspectRatio(
        aspectRatio: ResponsiveConstants.aspectRatioSquare,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ResponsiveConstants.radius16),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor.withValues(alpha: ResponsiveConstants.opacity20),
                blurRadius: ResponsiveConstants.elevation8,
                offset: Offset(0, ResponsiveConstants.spacing4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(ResponsiveConstants.radius16),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: _buildContent(context),
            ),
          ),
        ),
      ),
    );
  }

  String _getSemanticLabel() {
    final state = widget.state;
    if (state is RandomImageLoading) {
      return StringConstants.loadingRandomImage;
    } else if (state is RandomImageLoaded) {
      return StringConstants.randomImageLoadedFromUnsplash;
    } else if (state is RandomImageError) {
      return StringConstants.failedToLoadRandomImage;
    } else {
      return StringConstants.randomImageDisplayArea;
    }
  }

  String _getSemanticHint() {
    final state = widget.state;
    if (state is RandomImageLoading) {
      return StringConstants.pleaseWaitWhileTheImageIsBeingFetched;
    } else if (state is RandomImageLoaded) {
      return StringConstants.tapTheButtonBelowToLoadAnotherImage;
    } else if (state is RandomImageError) {
      return StringConstants.tapTheButtonBelowToTryLoadingAnotherImage;
    } else {
      return StringConstants.tapTheButtonBelowToLoadYourFirstRandomImage;
    }
  }

  Widget _buildContent(BuildContext context) {
    debugPrint('${StringConstants.buildingContentForState} ${widget.state.runtimeType}');

    if (widget.state is RandomImageLoading) {
      debugPrint(StringConstants.showingLoadingView);
      return _buildLoadingView();
    } else if (widget.state is RandomImageLoaded) {
      debugPrint(StringConstants.showingLoadedImageView);
      return _buildImageView(widget.state as RandomImageLoaded);
    } else if (widget.state is RandomImageError) {
      debugPrint('${StringConstants.showingErrorView} ${(widget.state as RandomImageError).message}');
      return _buildErrorView(widget.state as RandomImageError);
    } else {
      debugPrint(StringConstants.showingInitialView);
      return _buildInitialView();
    }
  }

  Widget _buildLoadingView() {
    return Container(
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildImageView(RandomImageLoaded state) {
    debugPrint('${StringConstants.buildingImageViewForUrl} ${state.randomImage.url}');

    // Ensure WebViewController is initialized for this image
    if (_webViewController == null || _currentImageUrl != state.randomImage.url) {
      debugPrint(StringConstants.creatingNewWebViewControllerForNewImageUrl);
      _currentImageUrl = state.randomImage.url;
      _initializeWebViewController(state.randomImage.url);
    } else {
      debugPrint(StringConstants.reusingExistingWebViewControllerForSameImageUrl);
    }

    return Column(
      children: [
        // Main content area with WebView and shimmer overlay
        Expanded(
          child: Stack(
            children: [
              // WebView for ultra-fast image loading - keep it visible underneath shimmer
              WebViewWidget(
                controller: _webViewController!,
              ),

              // Shimmer overlay on top of WebView while loading - creates elegant loading effect
              if (_isWebViewLoading)
                Positioned.fill(
                  child: Shimmer.fromColors(
                    baseColor: Colors.white.withValues(alpha: 0.3),
                    highlightColor: Colors.white.withValues(alpha: 0.1),
                    period: const Duration(milliseconds: 1500),
                    child: Container(
                      color: Colors.white.withValues(alpha: 0.2),
                      child: Center(
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.grey[300]!.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(ResponsiveConstants.radius16),
                          ),
                          child: Icon(
                            Icons.image,
                            size: ResponsiveConstants.iconSize48,
                            color: Colors.white.withValues(alpha: 0.7),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),

        // Progress indicator below the image
        if (_isWebViewLoading)
          Container(
            padding: EdgeInsets.all(ResponsiveConstants.spacing16),
            child: Column(
              children: [
                // Progress bar
                LinearProgressIndicator(
                  value: _loadingProgress,
                  backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
                  borderRadius: BorderRadius.circular(ResponsiveConstants.radius8),
                ),
                SizedBox(height: ResponsiveConstants.spacing8),
                // Progress text
                Text(
                  '${StringConstants.loadingImage} ${(_loadingProgress * 100).round()}%',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontSize: ResponsiveConstants.fontSize12,
                    fontWeight: ResponsiveConstants.fontWeightMedium,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
      ],
    );
  }

  String _buildImageHtml(String imageUrl) {
    return StringConstants.buildImageHtml(imageUrl);
  }




  Widget _buildErrorView(RandomImageError state) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: widget.onRetry,
      child: Container(
        color: theme.colorScheme.error.withValues(alpha: ResponsiveConstants.opacity10),
        child: Center(
          child: Padding(
            padding: ResponsiveConstants.screenPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.wifi_off_rounded,
                  color: theme.colorScheme.error,
                  size: ResponsiveConstants.iconSize48,
                ),
                SizedBox(height: ResponsiveConstants.spacing16),
                Text(
                  StringConstants.unableToLoadImage,
                  style: TextStyle(
                    color: theme.colorScheme.error,
                    fontSize: ResponsiveConstants.fontSize16,
                    fontWeight: ResponsiveConstants.fontWeightMedium,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: ResponsiveConstants.spacing8),
                Text(
                  _getUserFriendlyErrorMessage(state.message),
                  style: TextStyle(
                    color: theme.colorScheme.onError.withValues(alpha: 0.8),
                    fontSize: ResponsiveConstants.fontSize14,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: ResponsiveConstants.spacing16),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveConstants.spacing16,
                    vertical: ResponsiveConstants.spacing8,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.error.withValues(alpha: ResponsiveConstants.opacity20),
                    borderRadius: BorderRadius.circular(ResponsiveConstants.radius8),
                    border: Border.all(
                      color: theme.colorScheme.error.withValues(alpha: ResponsiveConstants.opacity30),
                      width: ResponsiveConstants.borderWidth1,
                    ),
                  ),
                  child: Text(
                    StringConstants.tapToRetry,
                    style: TextStyle(
                      color: theme.colorScheme.error,
                      fontSize: ResponsiveConstants.fontSize14,
                      fontWeight: ResponsiveConstants.fontWeightMedium,
                    ),
                  ),
                ),
                SizedBox(height: ResponsiveConstants.spacing8),
                Text(
                  StringConstants.orUseTheAnotherButtonBelow,
                  style: TextStyle(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontSize: ResponsiveConstants.fontSize12,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getUserFriendlyErrorMessage(String errorMessage) {
    if (errorMessage.contains('timeout') || errorMessage.contains('Timeout')) {
      return StringConstants.theImageIsTakingTooLongToLoadThisMightBeDueToASlowConnectionOrLargeImageSize;
    } else if (errorMessage.contains('connection') || errorMessage.contains('network')) {
      return StringConstants.pleaseCheckYourInternetConnectionAndTryAgain;
    } else if (errorMessage.contains('server') || errorMessage.contains('Server')) {
      return StringConstants.theImageServiceIsTemporarilyUnavailablePleaseTryAgainInAMoment;
    } else if (errorMessage.contains('rate') || errorMessage.contains('too many')) {
      return StringConstants.youveMadeTooManyRequestsPleaseWaitAMomentBeforeTryingAgain;
    } else {
      return StringConstants.anUnexpectedErrorOccurredPleaseTryLoadingADifferentImage;
    }
  }

  Widget _buildInitialView() {
    final theme = Theme.of(context);
    return Container(
      color: theme.colorScheme.surfaceVariant,
      child: Center(
        child: Text(
          StringConstants.tapAnotherToLoadAnImage,
          style: TextStyle(
            fontSize: ResponsiveConstants.fontSize16,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
