import { WalletService } from 'src/modules/wallet/wallet.service';
import { UserService } from '../user.service';
import { Inject } from '@nestjs/common';

export class RegisterUserUseCase {
  @Inject(UserService)
  private readonly userService: UserService;
  
  @Inject(WalletService)
  private readonly walletService: WalletService;

  registerUser() {
    this.userService.createUser();
    this.walletService.createWallet();
  }
}
