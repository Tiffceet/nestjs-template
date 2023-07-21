import {
  Inject,
  Injectable,
  Logger,
  NotFoundException,
  OnModuleInit,
} from '@nestjs/common';
import { IAdapter } from '../seamless.interface';
import { SeamlessProviderService } from '../seamless.service';

@Injectable()
export class AWCAdapter implements IAdapter {
  @Inject(SeamlessProviderService)
  private readonly seamlessProviderService: SeamlessProviderService;

  constructor() {}

  async launchGame(): Promise<void> {
    Logger.log('/awc/launchGame');
    return;
  }
  async syncGame(): Promise<void> {
    Logger.log('/awc/syncGame');
    return;
  }

  wallet() {
    this.seamlessProviderService.debit()
    this.seamlessProviderService.findOneTransaction()
    this.seamlessProviderService.rollback()
    this.seamlessProviderService.withdraw()
    return '/awc/wallet';
  }
}
