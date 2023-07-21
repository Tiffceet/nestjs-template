import { Controller, Post } from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { LoginAndRegisterUseCase } from './use-case/login-and-register';

@Controller('complex')
@ApiTags('complex')
export class ComplexController {
  constructor(private loginAndRegisterUseCase: LoginAndRegisterUseCase) {}

  @Post('signupAndLogin')
  signupAndLogin() {
    this.loginAndRegisterUseCase.loginAndRegister();
  }
}
