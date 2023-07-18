import { Module } from '@nestjs/common';
import { TransactionRepository } from 'src/repositories/transaction.repository';
import { TransactionService } from './transaction.service';
import { TransactionController } from 'src/modules/transaction/transaction.controller';
import { PrismaService } from 'src/providers/prisma/prisma.service';
import { ConfigModule } from '@nestjs/config';
import { PromotionService } from '../promotion/promotion.service';
import { PromotionTransactionAggregateService } from './aggregates/promotion-transaction.service';

@Module({
  imports: [ConfigModule],
  controllers: [TransactionController],
  providers: [
    TransactionService,
    PromotionService,
    PromotionTransactionAggregateService,
    TransactionRepository,
    PrismaService,
  ],
  exports: [],
})
export class TransactionModule {}
