export interface ITank {
  id: string;
  model: string;
  capacity: number;
  initialMeasure: number;
  finalMeasure: number;
}
export interface ITankCreateDTO {
  model: string;
  capacity: number;
  initialMeasure: number;
  finalMeasure: number;
}

export interface ITankCalculateDTO {
  id: string;
  valueByLiter: string;
}

export interface ITankCalculateResponse {
  status: boolean;
  value: string;
  filled: string;
}

export interface ITankProvider {
  create(tank: ITankCreateDTO): Promise<ITank>;
  list(): Promise<ITank[]>;
  listById(id: string): Promise<ITank | undefined>;
  update(id: string, updates: Partial<ITankCreateDTO>): Promise<ITank | null>;
  calculate(tank: ITankCalculateDTO): Promise<ITankCalculateResponse | null>;
}
