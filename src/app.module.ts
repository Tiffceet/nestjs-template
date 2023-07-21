import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { TransactionModule } from './modules/transaction/transaction.module';
import { PrismaService } from './providers/prisma/prisma.service';
import { TransactionRepository } from './repositories/transaction.repository';
import { ConfigModule } from '@nestjs/config';
import { SeamlessModule } from './modules/game-providers/seamless/seamless.module';
import { UserModule } from './modules/user/user.module';

@Module({
  imports: [ConfigModule.forRoot(), TransactionModule, SeamlessModule, UserModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
