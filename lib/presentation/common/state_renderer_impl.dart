import 'package:flutter/material.dart';
import 'package:flutteradvancedmvvm/data/mapper/mapper.dart';
import 'package:flutteradvancedmvvm/presentation/common/state_renderer.dart';
import 'package:flutteradvancedmvvm/presentation/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getmessage();
}

//? Loading State (POPUP, FULL SCREEN)
class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String message;
  LoadingState({required this.stateRendererType, String? message})
      : message = message ?? AppStrings.loading.tr();
  @override
  String getmessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

//? Error State (POPUP, FULL SCREEN)
class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;
  ErrorState(this.stateRendererType, this.message);
  @override
  String getmessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

//? EMPTY State
class EmptyState extends FlowState {
  String message;
  EmptyState(this.message);
  @override
  String getmessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.EMPTY_SCREEN_STATE;
}

//? FORGOT PASSWORD SENT State
class SuccessState extends FlowState {

  String message;
  SuccessState(this.message);
  @override
  String getmessage() => message;

  @override
  StateRendererType getStateRendererType() => StateRendererType.POPUP_SUCCESS;
}

//? Content State
class ContentState extends FlowState {
  ContentState();
  @override
  String getmessage() => EMPTY;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.CONTENT_SCREEN_STATE;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (runtimeType) {
      case LoadingState:
        {
          if (getStateRendererType() == StateRendererType.POPUP_LOADING_STATE) {
            showPopPup(context, getStateRendererType(), getmessage());
            return contentScreenWidget;
          } else {
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getmessage(),
              retryActionFunction: retryActionFunction,
            );
          }
        }
      case ErrorState:
        {
          dismissDialog(context);

          if (getStateRendererType() == StateRendererType.POPUP_ERROR_STATE) {
            showPopPup(context, getStateRendererType(), getmessage());
            return contentScreenWidget;
          } else {
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getmessage(),
              retryActionFunction: retryActionFunction,
            );
          }
        }
      case SuccessState:
        {
          dismissDialog(context);
           showPopPup(context, getStateRendererType(), getmessage());
          return contentScreenWidget;
        }
      case EmptyState:
        {
          return StateRenderer(
            stateRendererType: getStateRendererType(),
            message: getmessage(),
          );
        }
      case ContentState:
        {
          dismissDialog(context);
          return contentScreenWidget;
        }
      default:
        {
          return contentScreenWidget;
        }
    }
  }

  dismissDialog(BuildContext context) {
    if (_isThereCurrentDialogShowing(context)) {
      //! rootnavigator full screen dialog icin tabbari kapatir sadece dialog gozukur true olunca
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  _isThereCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  showPopPup(BuildContext context, StateRendererType stateRendererType,
      String message) {
    WidgetsBinding.instance?.addPostFrameCallback((_) => showDialog(
        context: context,
        builder: (context) => StateRenderer(
              stateRendererType: stateRendererType,
              message: message,
              retryActionFunction: () {},
            )));
  }
}
