import { Inject, Injectable, Logger } from '@nestjs/common';
import {
  DelegateArgs,
  DelegateReturnTypes,
  PrismaRepository,
} from './prisma.repository';
import { Prisma, PrismaClient } from '@prisma/client';
import { PrismaService } from 'src/providers/prisma/prisma.service';

type TransactionDelegate = Prisma.TransactionDelegate;

@Injectable()
export class TransactionRepository extends PrismaRepository<
  TransactionDelegate,
  DelegateArgs<TransactionDelegate>,
  DelegateReturnTypes<TransactionDelegate>
> {

  @Inject(PrismaService)
  protected readonly prisma: PrismaService

  constructor() {
    super(new PrismaClient().transaction, Prisma.ModelName.Transaction)
  }

  async findPromotionTransactions() {
    Logger.log('TransactionRepository.findPromotionTransactions');
  }
}
