import { v4 as uuid } from "uuid";
import * as fs from "fs";
import { ITank, ITankCreateDTO, ITankProvider } from "../../models";
import { ITankCalculateDTO, ITankCalculateResponse } from "../../models/tanks";

const FILE_PATH = "assets/tanks.json";

export class TankProviderFile implements ITankProvider {
  private tanks: ITank[];

  constructor() {
    this.tanks = this.loadFromFile();
  }

  async calculate(
    tank: ITankCalculateDTO
  ): Promise<ITankCalculateResponse | null> {
    let resp: ITankCalculateResponse = {
      value:"0",
      status: true,
      filled:"0",
    };

    const [tankInBase] = this.tanks.filter((t) => t.id == tank.id);
    if (!tankInBase) {
      return null;
    }

    const totalValue = (tankInBase.finalMeasure - tankInBase.initialMeasure)  *  Number(tank.valueByLiter);
    resp.value = String(totalValue.toFixed(2)); 
    resp.filled = String((tankInBase.finalMeasure - tankInBase.initialMeasure).toFixed(2));

    return resp;
  }

  private loadFromFile(): ITank[] {
    try {
      const data = fs.readFileSync(FILE_PATH, "utf-8");
      return JSON.parse(data) as ITank[];
    } catch (error) {
      return [];
    }
  }

  private saveToFile(): void {
    fs.writeFileSync(FILE_PATH, JSON.stringify(this.tanks, null, 2), "utf-8");
  }

  async create(tank: ITankCreateDTO): Promise<ITank> {
    const p = {
      id: uuid(),
      created_at: new Date().toLocaleString(),
      ...tank,
    } as ITank;
    this.tanks.push(p);
    this.saveToFile();
    return p;
  }

  async list(): Promise<ITank[]> {
    return this.tanks;
  }

  async listById(id: string): Promise<ITank | undefined> {
    return this.tanks.find((tank) => tank.id == id);
  }

  async update(
    id: string,
    updates: Partial<ITankCreateDTO>
  ): Promise<ITank | null> {
    const userIndex = this.tanks.findIndex((user) => user.id === id);

    if (userIndex === -1) {
      return null;
    }

    this.tanks[userIndex] = {
      ...this.tanks[userIndex],
      ...updates,
    };

    this.saveToFile();
    return this.tanks[userIndex];
  }
}
