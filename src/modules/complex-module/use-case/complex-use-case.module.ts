import { Module } from '@nestjs/common';
import { LoginAndRegisterUseCase } from './login-and-register';
import { UserUseCaseModule } from 'src/modules/user/use-case/user-use-case.module';

@Module({
  controllers: [],
  exports: [LoginAndRegisterUseCase],
  imports: [UserUseCaseModule],
  providers: [LoginAndRegisterUseCase],
})
export class ComplexUseCaseModule {}
