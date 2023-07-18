# Problem
## How to fix circular dependencies
Create aggregate service when needed. Aggregate service imports multiple smaller services and perform business logics that each individual smaller service cant.

E.g. Creating promotion transaction requires promotion and transaction service [promotion-transaction.service](https://github.com/Tiffceet/nestjs-template/blob/master/src/modules/transaction/aggregates/promotion-transaction.service.ts)
## How to fix direct prisma access
### Repository design pattern
A piece of code that its sole reponsiblitiy is to deal with database. 
Repository should be created as per business entity.

Examples:
- `Transaction` is an business entity
- `Promotion` is an business entity

### Proposed change
Service should not have direct access to `PrismaAbstract`. They should import repository to perform data operations

Why? Because `PrismaAbstract` is not abstract enough to perform complex queries and the service itself would need to access prisma directly again

Instead the current implementation of `PrismaAbstract` can be used as PrismaRepository which its sole purpose is to make a generic repository to access data.

Optimally, service should only contain business logic that doesnt care about db implementation

Code for reference:
- [`transaction.repository.ts` - Perform queries for transactions data](https://github.com/Tiffceet/nestjs-template/blob/master/src/repositories/transaction.repository.ts)
- [`transaction.service.ts` - Using repositories](https://github.com/Tiffceet/nestjs-template/blob/master/src/modules/transaction/transaction.service.ts)

## Reference
https://betterprogramming.pub/clean-node-js-architecture-with-nestjs-and-typescript-34b9398d790f