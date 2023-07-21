import { Module } from '@nestjs/common';
import { SeamlessAWCController } from './awc/awc.controller';
import { SeamlessProviderService } from './seamless.service';
import { AWCAdapter } from './awc/awc.adapter';

@Module({
  controllers: [SeamlessAWCController],
  exports: [],
  imports: [],
  providers: [SeamlessProviderService, AWCAdapter],
})
export class SeamlessModule {}
