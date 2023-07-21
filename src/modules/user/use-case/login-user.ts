import { WalletService } from 'src/modules/wallet/wallet.service';
import { UserService } from '../user.service';
import { Inject } from '@nestjs/common';

export class LoginUserUseCase {
  @Inject(UserService)
  private readonly userService: UserService;
  
  @Inject(WalletService)
  private readonly walletService: WalletService;

  loginUser() {
    this.userService.getUser();
    this.walletService.getWallet();
  }
}
