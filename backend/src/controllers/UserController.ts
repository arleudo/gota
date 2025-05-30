import { UserProviderFile } from "../providers/User/UserProviderFile";
import { UserService } from "../services";

import { Request, Response } from "express";

export class UserController {
  private service: UserService;

  constructor() {
    this.service = new UserService(new UserProviderFile());
  }

  public async create(req: Request, res: Response) {
    try {
      const { name, email, password } = req.body;

      if (!name || !email || !password) {
        return res.status(400).json({ error: "All fields are required." });
      }

      const user = await this.service.create(req.body);
      res.status(201).json(user);
    } catch (error) {
      res
        .status(500)
        .json({ error: "An error occurred while creating the user." });
    }
  }

  public async login(req: Request, res: Response) {
    console.log(req.body);
    
    try {
      const { email, password } = req.body;

      if (!email || !password) {
        return res.status(400).json({ error: "All fields are required." });
      }

      const user = await this.service.login(req.body);
      res.status(200).json(user);
    } catch (error) {
      res
        .status(440)
        .json({ error: "An error occurred while login the user." });
    }
  }

  public async list(req: Request, res: Response) {
    try {
      const users = await this.service.list();
      res.status(200).json(users);
    } catch (error) {
      res
        .status(500)
        .json({ error: "An error occurred while fetching the users." });
    }
  }

  public async update(req: Request, res: Response) {
    try {
      const { id } = req.params;
      const updates = req.body;

      if (!updates.name && !updates.email && !updates.password) {
        return res.status(400).json({ error: "No fields to update." });
      }

      const updatedUser = await this.service.update(id, updates);

      if (!updatedUser) {
        return res.status(404).json({ error: "User not found." });
      }

      res.status(200).json(updatedUser);
    } catch (error) {
      res
        .status(500)
        .json({ error: "An error occurred while updating the user." });
    }
  }
}
