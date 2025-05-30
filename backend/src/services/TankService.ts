import { ITank, ITankCreateDTO, ITankProvider } from "../models";
import { ITankCalculateDTO, ITankCalculateResponse } from "../models/tanks";

export class TankService {
  private provider: ITankProvider;

  constructor(provider: ITankProvider) {
    this.provider = provider;
  }

  async create(tank: ITankCreateDTO): Promise<ITank> {
    const created = await this.provider.create(tank);
    return created;
  }

  async list(): Promise<ITank[]> {
    const users = await this.provider.list();
    return users;
  }

  async update(
    id: string,
    updates: Partial<ITankCreateDTO>
  ): Promise<ITank | null> {
    const updated = await this.provider.update(id, updates);
    return updated;
  }

  async calculate(
    tank: ITankCalculateDTO
  ): Promise<ITankCalculateResponse | null> {
    const resp = await this.provider.calculate(tank);
    return resp;
  }

  async listById(id: string): Promise<ITank | undefined> {
    return await this.provider.listById(id);
  }
}
