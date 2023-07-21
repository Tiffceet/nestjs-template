import { Body, Controller, HttpCode, Inject, Logger, Post } from '@nestjs/common'
import { ApiCreatedResponse, ApiTags } from '@nestjs/swagger'
import { AWCAdapter } from './awc.adapter'

@Controller('seamless/awc')
@ApiTags('seamless/awc')
export class SeamlessAWCController {
  constructor(private awcAdapter: AWCAdapter) {}

  @Post('wallet')
  @HttpCode(200)
  @ApiCreatedResponse()
  async balance(@Body() request: any) {
    return this.awcAdapter.wallet()
  }
}
