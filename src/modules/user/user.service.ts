import { Injectable, Logger } from '@nestjs/common';

@Injectable()
export class UserService {
  createUser() {
    Logger.log('userService.createUser');
  }
  getUser() {
    Logger.log('userService.getUser');
  }
}
