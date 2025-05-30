import { IUser, IUserCreateDTO, IUserProvider } from "../../models";
import { v4 as uuid } from "uuid";

export class UserProviderMemory implements IUserProvider {
  private users: IUser[] = [];

  async create(user: IUserCreateDTO): Promise<IUser> {
    const newUser: IUser = {
      id: uuid(),
      ...user,
    };
    this.users.push(newUser);
    return newUser;
  }

  async list(): Promise<IUser[]> {
    return this.users;
  }

  async update(
    id: string,
    updates: Partial<IUserCreateDTO>
  ): Promise<IUser | null> {
    const userIndex = this.users.findIndex((user) => user.id === id);

    if (userIndex === -1) {
      return null;
    }

    this.users[userIndex] = {
      ...this.users[userIndex],
      ...updates,
    };
    return this.users[userIndex];
  }
}
