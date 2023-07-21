import { Injectable, Logger } from '@nestjs/common';

@Injectable()
export class WalletService {
  addMoney() {
    Logger.log('walletService.addMoney');
  }
  removeMoney() {
    Logger.log('walletService.addMoney');
  }

  createWallet() {
    Logger.log('walletService.createWallet');
  }

  getWallet() {
    Logger.log('walletService.getWallet');
  }
}
