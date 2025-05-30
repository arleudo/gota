import { Request, Response } from "express";
import { TankService } from "../services";
import { TankProviderFile } from "../providers/Tank/TankProviderFile";

export class TankController {
  private service: TankService;

  constructor() {
    this.service = new TankService(new TankProviderFile());
  }

  public async create(req: Request, res: Response) {
    try {
      const { model, capacity } = req.body;

      if (!model || !capacity) {
        return res.status(400).json({ error: "All fields are required." });
      }

      const tank = await this.service.create(req.body);
      res.status(201).json(tank);
    } catch (error) {
      res
        .status(500)
        .json({ error: "An error occurred while creating the tank." });
    }
  }

  public async list(req: Request, res: Response) {
    try {
      const {id} = req.params;
      if(id){
        const tank = await this.service.listById(id);
      res.status(200).json(tank);  
      }
      const tanks = await this.service.list();
      res.status(200).json(tanks);
    } catch (error) {
      res
        .status(500)
        .json({ error: "An error occurred while fetching the tanks." });
    }
  }

  public async update(req: Request, res: Response) {
    try {
      const { id } = req.params;
      const updates = req.body;

      const updatedtank = await this.service.update(id, updates);

      if (!updatedtank) {
        return res.status(404).json({ error: "Tank not found." });
      }

      res.status(200).json(updatedtank);
    } catch (error) {
      res
        .status(500)
        .json({ error: "An error occurred while updating the tank." });
    }
  }

  public async calculate(req: Request, res: Response) {
    console.log(req.body);
    
    try {
      const calculate = req.body;

      const calculated = await this.service.calculate(calculate);

      console.log(calculated);
      

      res.status(200).json(calculated);
    } catch (error) {
      res
        .status(500)
        .json({ error: "An error occurred while calculating the tank." });
    }
  }
}
