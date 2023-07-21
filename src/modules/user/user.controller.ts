import { Controller, Post } from '@nestjs/common';
import { RegisterUserUseCase } from './use-case/register-user';
import { ApiTags } from '@nestjs/swagger';
import { LoginUserUseCase } from './use-case/login-user';
@Controller('user')
@ApiTags('user')
export class UserController {
  constructor(private registerUserUseCase: RegisterUserUseCase, private loginUserUseCase: LoginUserUseCase) {}

  @Post('signup')
  signup() {
    this.registerUserUseCase.registerUser();
  }
  
  @Post('login')
  login() {
    this.loginUserUseCase.loginUser();
  }
}
