import { Injectable, Logger } from '@nestjs/common';

@Injectable()
export class SeamlessProviderService {
  async debit() {
    Logger.log('debit()');
  }
  async withdraw() {
    Logger.log('withdraw()');
  }
  async rollback() {
    Logger.log('rollback()');
  }
  async findOneTransaction() {
    Logger.log('findOneTransaction()');
  }
}
