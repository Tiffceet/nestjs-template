import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { TransactionModule } from './modules/transaction/transaction.module';
import { PrismaService } from './providers/prisma/prisma.service';
import { TransactionRepository } from './repositories/transaction.repository';
import { ConfigModule } from '@nestjs/config';

@Module({
  imports: [ConfigModule.forRoot(), TransactionModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
