import express from "express";
import { UserController } from "../controllers";

const UserRouter = express.Router();

const controller = new UserController();

UserRouter.post("/", controller.create.bind(controller));
UserRouter.post("/login", controller.login.bind(controller));
UserRouter.get("/", controller.list.bind(controller));
UserRouter.put("/:id", controller.update.bind(controller));

export default UserRouter;
