import { Module } from '@nestjs/common';
import { ComplexController } from './complex.controller';
import { UserUseCaseModule } from '../user/use-case/user-use-case.module';
import { ComplexUseCaseModule } from './use-case/complex-use-case.module';

@Module({
  controllers: [ComplexController],
  exports: [],
  imports: [ComplexUseCaseModule],
  providers: [],
})
export class ComplexModule {}
