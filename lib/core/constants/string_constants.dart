/// String constants for consistent text throughout the app
class StringConstants {
  // App Information
  static const String appName = 'Random Image App';

  // Debug Messages
  static const String mainStartingAppInit = 'Main: Starting app initialization';
  static const String mainDependencyInjectionInitialized = 'Main: Dependency injection initialized';
  static const String myAppBuildingWithScreenUtilInit = 'MyApp: Building app with ScreenUtilInit';
  static const String homeScreenInitStateFetchingInitialImage = 'HomeScreen: initState - fetching initial image';
  static const String homeScreenBlocBuilderState = 'HomeScreen: BlocBuilder - state:';
  static const String homeScreenButtonPressedFetchingNewImage = 'HomeScreen: Button pressed - fetching new image';
  static const String injectionCreatingRandomImageBloc = 'Injection: Creating RandomImageBloc';
  static const String repositoryValidatingUrl = 'Repository: Validating URL:';
  static const String repositoryUrlValidationFailed = 'Repository: URL validation failed for:';
  static const String repositoryUrlValidationPassed = 'Repository: URL validation passed';
  static const String repositoryFailedToParseServerResponse = 'Repository: Failed to parse server response';
  static const String buildingContentForState = 'Building content for state:';
  static const String showingLoadingView = 'Showing loading view';
  static const String showingLoadedImageView = 'Showing loaded image view';
  static const String showingErrorView = 'Showing error view:';
  static const String showingInitialView = 'Showing initial view';
  static const String buildingImageViewForUrl = 'Building image view for URL:';
  static const String creatingNewWebViewControllerForNewImageUrl = 'Creating new WebViewController for new image URL';
  static const String reusingExistingWebViewControllerForSameImageUrl = 'Reusing existing WebViewController for same image URL';
  static const String initializingWebViewControllerForImage = 'Initializing WebViewController for image:';
  static const String webViewLoadingProgress = 'WebView loading progress:';
  static const String webViewStartedLoading = 'WebView started loading:';
  static const String webViewPageFinishedLoading = 'WebView page finished loading:';
  static const String webViewLoadingCompletedShowingImage = 'WebView loading completed, showing image';
  static const String webViewResourceError = 'WebView resource error:';
  static const String blocStartingToFetchRandomImage = 'BLoC: Starting to fetch random image';
  static const String blocFailedToFetchImage = 'BLoC: Failed to fetch image:';
  static const String blocErrorType = 'BLoC: Error type:';
  static const String blocSuccessfullyFetchedImageUrl = 'BLoC: Successfully fetched image URL:';
  static const String blocDominantColorExtractionSkippedSetToNull = 'BLoC: Dominant color extraction skipped (set to null)';
  static const String blocEmittedRandomImageErrorState = 'BLoC: Emitted RandomImageError state';
  static const String blocEmittedRandomImageLoadedState = 'BLoC: Emitted RandomImageLoaded state';

  // UI Text
  static const String another = 'Another';
  static const String loading = 'Loading...';
  static const String loadingNewImage = 'Loading new image';
  static const String loadAnotherRandomImage = 'Load another random image';
  static const String tapToFetchANewRandomImageFromTheServer = 'Tap to fetch a new random image from the server';
  static const String tapAnotherToLoadAnImage = 'Tap "Another" to load an image';
  static const String loadingImage = 'Loading image...';

  // Semantic Labels and Accessibility
  static const String button = 'Button';
  static const String appBar = 'App bar';
  static const String themeToggle = 'Theme toggle';
  static const String switchToLightMode = 'Switch to light mode';
  static const String switchToDarkMode = 'Switch to dark mode';

  // Error Messages
  static const String unableToLoadImage = 'Unable to load image';
  static const String tapToRetry = 'Tap to retry';
  static const String orUseTheAnotherButtonBelow = 'Or use the "Another" button below';
  static const String receivedInvalidImageUrlFromServer = 'Received invalid image URL from server';
  static const String failedToParseServerResponse = 'Failed to parse server response';
  static const String tooManyRequestsPleaseTryAgainLater = 'Too many requests. Please try again later.';
  static const String serverIsTemporarilyUnavailablePleaseTryAgain = 'Server is temporarily unavailable. Please try again.';
  static const String serverReturnedError = 'Server returned error:';
  static const String unexpectedErrorOccurred = 'Unexpected error occurred:';
  static const String failedToLoadImageAfterMultipleAttempts = 'Failed to load image after multiple attempts';

  // Error Descriptions
  static const String theImageIsTakingTooLongToLoadThisMightBeDueToASlowConnectionOrLargeImageSize = 'The image is taking too long to load. This might be due to a slow connection or large image size.';
  static const String pleaseCheckYourInternetConnectionAndTryAgain = 'Please check your internet connection and try again.';
  static const String theImageServiceIsTemporarilyUnavailablePleaseTryAgainInAMoment = 'The image service is temporarily unavailable. Please try again in a moment.';
  static const String youveMadeTooManyRequestsPleaseWaitAMomentBeforeTryingAgain = 'You\'ve made too many requests. Please wait a moment before trying again.';
  static const String anUnexpectedErrorOccurredPleaseTryLoadingADifferentImage = 'An unexpected error occurred. Please try loading a different image.';

  // Semantic Labels for States
  static const String loadingRandomImage = 'Loading random image';
  static const String randomImageLoadedFromUnsplash = 'Random image loaded from Unsplash';
  static const String failedToLoadRandomImage = 'Failed to load random image';
  static const String randomImageDisplayArea = 'Random image display area';
  static const String pleaseWaitWhileTheImageIsBeingFetched = 'Please wait while the image is being fetched';
  static const String tapTheButtonBelowToLoadAnotherImage = 'Tap the button below to load another image';
  static const String tapTheButtonBelowToTryLoadingAnotherImage = 'Tap the button below to try loading another image';
  static const String tapTheButtonBelowToLoadYourFirstRandomImage = 'Tap the button below to load your first random image';

  // HTML Content
  static const String randomImage = 'Random Image';
  static const String imageLoadedSuccessfully = 'Image loaded successfully';
  static const String imageFailedToLoad = 'Image failed to load';

  // HTML Template
  static String buildImageHtml(String imageUrl) {
    return '''
      <!DOCTYPE html>
      <html>
        <head>
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <style>
            body {
              margin: 0;
              padding: 0;
              display: flex;
              justify-content: center;
              align-items: center;
              height: 100vh;
              background: transparent;
            }
            img {
              max-width: 100%;
              max-height: 100%;
              object-fit: cover;
              width: 100%;
              height: 100%;
            }
          </style>
        </head>
        <body>
          <img src="$imageUrl" alt="$randomImage" onload="console.log('$imageLoadedSuccessfully')" onerror="console.log('$imageFailedToLoad')">
        </body>
      </html>
    ''';
  }
}
