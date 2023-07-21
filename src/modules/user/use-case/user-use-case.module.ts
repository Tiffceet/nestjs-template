import { Module } from '@nestjs/common';
import { RegisterUserUseCase } from './register-user';
import { UserService } from '../user.service';
import { WalletService } from 'src/modules/wallet/wallet.service';
import { LoginUserUseCase } from './login-user';

@Module({
  controllers: [],
  exports: [RegisterUserUseCase, LoginUserUseCase],
  imports: [],
  providers: [RegisterUserUseCase, LoginUserUseCase, UserService, WalletService],
})
export class UserUseCaseModule {}
