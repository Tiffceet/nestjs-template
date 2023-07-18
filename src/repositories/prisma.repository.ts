import { Inject } from '@nestjs/common'
import { Prisma } from '@prisma/client'
import { PrismaService } from 'src/providers/prisma/prisma.service'

/* Usage



type AccountDelegate = Prisma.AccountDelegate<unknown>
@Injectable()
export class TestAccountService extends PrismaRepo<
  AccountDelegate,
  DelegateArgs<AccountDelegate>,
  DelegateReturnTypes<AccountDelegate>
> {
  @Inject(PrismaService)
  protected readonly prisma: PrismaService

  constructor() {
    super(new PrismaClient().account, Prisma.ModelName.Account)
  }

  createSpecial() {
    return this.findManyPaginated({ select: { tenant: { select: { id: true } } } })
  }

  rotiCanai() {
    return this.findManyPaginated({
      take: 10,
      skip: 0,
    })
  }
}
 */

type Operations =
  | 'aggregate'
  | 'count'
  | 'create'
  | 'createMany'
  | 'delete'
  | 'deleteMany'
  | 'findFirst'
  | 'findMany'
  | 'findUnique'
  | 'update'
  | 'updateMany'
  | 'upsert'

export type AnyRecord = Record<string, any>

export abstract class PrismaRepository<
  D extends { [K in Operations]: (args: unknown) => unknown },
  A extends { [K in Operations]: unknown },
  R extends { [K in Operations]: unknown }
> {
  protected abstract readonly prisma: PrismaService

  constructor(protected model: D, protected modelName: Prisma.ModelName) {}

  async findUnique(args: A['findUnique'], tx?: Prisma.TransactionClient): Promise<R['findUnique']> {
    return await (tx ?? this.prisma)[this.modelName].findUnique(args)
  }

  async findFirst(args: A['findFirst'], tx?: Prisma.TransactionClient): Promise<R['findFirst']> {
    return await (tx ?? this.prisma)[this.modelName].findFirst(args)
  }

  async findMany(args: A['findMany'], tx?: Prisma.TransactionClient): Promise<R['findMany']> {
    return await (tx ?? this.prisma)[this.modelName].findMany(args)
  }

  async create(args: A['create'], tx?: Prisma.TransactionClient): Promise<R['create']> {
    return await (tx ?? this.prisma)[this.modelName].create(args)
  }

  async createMany(args: A['createMany'], tx?: Prisma.TransactionClient): Promise<R['createMany']> {
    return await (tx ?? this.prisma)[this.modelName].createMany(args)
  }

  async update(args: A['update'], tx?: Prisma.TransactionClient): Promise<R['update']> {
    return await (tx ?? this.prisma)[this.modelName].update(args)
  }

  async delete(args: A['delete'], tx?: Prisma.TransactionClient): Promise<R['delete']> {
    return await (tx ?? this.prisma)[this.modelName].delete(args)
  }

  async upsert(args: A['upsert'], tx?: Prisma.TransactionClient): Promise<R['upsert']> {
    return await (tx ?? this.prisma)[this.modelName].upsert(args)
  }

  async count(args: A['count'], tx?: Prisma.TransactionClient): Promise<R['count']> {
    return await (tx ?? this.prisma)[this.modelName].count(args)
  }

  async aggregate(args: A['aggregate'], tx?: Prisma.TransactionClient): Promise<R['aggregate']> {
    return await (tx ?? this.prisma)[this.modelName].aggregate(args)
  }

  async deleteMany(args: A['deleteMany'], tx?: Prisma.TransactionClient): Promise<R['deleteMany']> {
    return await (tx ?? this.prisma)[this.modelName].deleteMany(args)
  }

  async updateMany(args: A['updateMany'], tx?: Prisma.TransactionClient): Promise<R['updateMany']> {
    return await (tx ?? this.prisma)[this.modelName].updateMany(args)
  }
}

export type DelegateArgs<T> = {
  [K in keyof T]: T[K] extends (args: infer A) => Promise<unknown> ? A : never
}

export type DelegateReturnTypes<T> = {
  [K in keyof T]: T[K] extends (args: infer A) => Promise<infer R> ? R : never
}
