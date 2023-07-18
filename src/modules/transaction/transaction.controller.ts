import {
  Body,
  Controller,
  Get,
  Param,
  Patch,
  Post,
  Query,
} from '@nestjs/common';

import { TransactionService } from 'src/modules/transaction/transaction.service';
import { PromotionTransactionAggregateService } from 'src/modules/transaction/aggregates/promotion-transaction.service';
@Controller('transaction')
export class TransactionController {
  constructor(
    private transactionService: TransactionService,
    private promotionTransactionAggregateService: PromotionTransactionAggregateService,
  ) {}

  @Post('create')
  createTransaction() {
    return this.transactionService.createTransaction();
  }

  @Post("createPromotionTransaction")
  createPromotionTransaction() {
    return this.promotionTransactionAggregateService.createPromotionTransaction();
  }
}
