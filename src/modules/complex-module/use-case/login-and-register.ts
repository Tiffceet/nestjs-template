import { Inject } from '@nestjs/common';
import { LoginUserUseCase } from 'src/modules/user/use-case/login-user';
import { RegisterUserUseCase } from 'src/modules/user/use-case/register-user';

export class LoginAndRegisterUseCase {
  @Inject(LoginUserUseCase)
  private readonly loginUserUseCase: LoginUserUseCase;

  @Inject(RegisterUserUseCase)
  private readonly registerUserUseCase: RegisterUserUseCase;

  loginAndRegister() {
    this.loginUserUseCase.loginUser();
    this.registerUserUseCase.registerUser();
  }
}
