import { Module } from '@nestjs/common';
import { UserController } from './user.controller';
import { RegisterUserUseCase } from './use-case/register-user';
import { UserService } from './user.service';
import { UserUseCaseModule } from './use-case/user-use-case.module';

@Module({
  imports: [UserUseCaseModule],
  controllers: [UserController],
  providers: [],
})
export class UserModule {}
