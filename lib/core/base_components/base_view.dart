import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_brain/core/app_constants.dart';
import 'package:second_brain/core/base_components/base_view_model.dart';
import 'package:second_brain/core/connectivity_helper.dart';

class BaseView<T> extends StatefulWidget {
  /// Attributes
  final void Function(T provider)? onInitState;
  final Widget Function(T provider) buildWidget;

  /// Constructor
  const BaseView({
    super.key,
    this.onInitState,
    required this.buildWidget,
  });

  @override
  State<BaseView<T>> createState() => _BaseViewState<T>();
}

class _BaseViewState<T> extends State<BaseView<T>> {
  bool _showLoader = false;

  /// Print a scafoldMessahe if no internet
  void checkInternetAvail() {
    ConnectivityCheckerHelper.listenToConnectivityChanged()
        .listen((ConnectivityResult connectivityResult) {
      if (connectivityResult == ConnectivityResult.none) {
        if (!mounted) {
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(appCommonConnectionFailedMessage),
          ),
        );
      }
    });
  }

  /// Listen stream toggleLoading from BaseViewModel and truen true if loading
  ///   state, false otherwise
  void toggleLoadingWidget(T provider) {
    (provider as BaseViewModel).toggleLoading.stream.listen((bool show) {
      if (!mounted) return;
      setState(() {
        _showLoader = show;
      });
    });
  }

  @override
  void initState() {
    final provider = Provider.of<T>(context, listen: false);
    checkInternetAvail();
    toggleLoadingWidget(provider);
    if (widget.onInitState != null) {
      widget.onInitState!(provider);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: (BuildContext context, T provider, Widget? child) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            widget.buildWidget(provider),
            if (_showLoader)
              AnimatedOpacity(
                opacity: 1,
                duration: const Duration(milliseconds: 500),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Container(
                    color: Colors.transparent,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        padding: const EdgeInsets.all(15),
                        width: 70,
                        height: 70,
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
