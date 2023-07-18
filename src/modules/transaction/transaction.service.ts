import { Inject, Injectable, Logger } from '@nestjs/common';
import { TransactionRepository } from 'src/repositories/transaction.repository';

@Injectable()
export class TransactionService {
  @Inject(TransactionRepository)
  private readonly transactionRepository: TransactionRepository;

  async createTransaction() {
    await this.transactionRepository.create({
      data: {
        amount: 0,
        currency: 'IDR',
        purpose: 'BET',
        tenant: {
          create: {
            name: '',
          },
        },
        user: {
          create: {
            currency: 'IDR',
            role: {
              create: {
                name: '',
              },
            },
          },
        },
        wallet: {
          create: {
            currency: 'IDR',
            purpose: 'BONUS',
            user: {
              create: {
                currency: 'IDR',
                role: {
                  create: {
                    name: '',
                  },
                },
              },
            },
          },
        },
      },
    });
    Logger.log('createTransaction()');
  }
}
