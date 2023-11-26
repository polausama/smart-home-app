abstract class SmartHomeState {}

class InitialState extends SmartHomeState {}

class BottomNavigationBarStateIndexChanged extends SmartHomeState {}

class LightStateOn extends SmartHomeState {}

class LightStateOff extends SmartHomeState {}

class LoadingStates extends SmartHomeState{

}
class PostStates extends SmartHomeState{

}
class ErrorStates extends SmartHomeState{

}

class LoadingSendingStates extends SmartHomeState{

}
class GatStates extends SmartHomeState{

}
class ErrorSendingStates extends SmartHomeState{

}

class LoadingReceivingStates extends SmartHomeState{

}


class ReceivingStates extends SmartHomeState{

}
class ErrorReceivingStates extends SmartHomeState{

}
class TogglePasswordState extends SmartHomeState{

}

class SignupLoadingStates extends SmartHomeState{}
class SignupSuccessStates extends SmartHomeState{}
class SignupErrorStates extends SmartHomeState{}

class LoginLoadingStates extends SmartHomeState{}
class LoginSuccessStates extends SmartHomeState{}
class LoginErrorStates extends SmartHomeState{}
