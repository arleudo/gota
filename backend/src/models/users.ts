export interface IUser {
  id: string;
  name: string;
  email: string;
  password: string;
  logged: boolean;
}

export interface IUserCreateDTO {
  name: string;
  email: string;
  password: string;
}

export interface IUserLoginDTO {
  email: string;
  password: string;
}

export interface IUserProvider {
  create(user: IUserCreateDTO): Promise<IUser>;
  list(): Promise<IUser[]>;
  update(id: string, updates: Partial<IUserCreateDTO>): Promise<IUser | null>;
  login(user: IUserLoginDTO): Promise<IUser>;
}
