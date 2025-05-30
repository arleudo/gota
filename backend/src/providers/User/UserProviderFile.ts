import { v4 as uuid } from "uuid";
import { IUser, IUserCreateDTO, IUserProvider } from "../../models";
import { FileUtils } from "../../utils/FileUtils";
import { IUserLoginDTO } from "../../models/users";

const FILE_PATH = "assets/users.json";

export class UserProviderFile implements IUserProvider {
  private users: IUser[];

  constructor() {
    this.users = FileUtils.loadFromFile(FILE_PATH) as IUser[];
  }

  async login(user: IUserLoginDTO): Promise<IUser> {
    const foundUser = this.users.find(
      (u) => u.email === user.email && u.password === user.password
    );

    if (!foundUser) {
      throw new Error("Invalid email or password");
    }

    foundUser.logged = true;
    FileUtils.saveToFile(this.users, FILE_PATH);
    return foundUser;
  }

  async create(user: IUserCreateDTO): Promise<IUser> {
    const p = {
      id: uuid(),
      created_at: new Date().toLocaleString(),
      logged: false,
      ...user,
    } as IUser;
    this.users.push(p);
    FileUtils.saveToFile(this.users, FILE_PATH);
    return p;
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

    FileUtils.saveToFile(this.users, FILE_PATH);
    return this.users[userIndex];
  }
}
