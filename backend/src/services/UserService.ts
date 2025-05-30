import { IUser, IUserCreateDTO, IUserLoginDTO, IUserProvider } from "../models";

export class UserService {
  private provider: IUserProvider;

  constructor(provider: IUserProvider) {
    this.provider = provider;
  }

  async create(user: IUserCreateDTO): Promise<IUser> {
    const created = await this.provider.create(user);
    return created;
  }

  async list(): Promise<IUser[]> {
    const users = await this.provider.list();
    return users;
  }

  async update(
    id: string,
    updates: Partial<IUserCreateDTO>
  ): Promise<IUser | null> {
    const updated = await this.provider.update(id, updates);
    return updated;
  }

  async login(user: IUserLoginDTO): Promise<IUser> {
    const created = await this.provider.login(user);
    return created;
  }
}
