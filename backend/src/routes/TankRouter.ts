import express from "express";
import { TankController } from "../controllers";

const TankRouter = express.Router();

const controller = new TankController();

TankRouter.post("/", controller.create.bind(controller));
TankRouter.get("/", controller.list.bind(controller));
TankRouter.get("/:id", controller.list.bind(controller));
TankRouter.put("/:id", controller.update.bind(controller));
TankRouter.post("/calculate", controller.calculate.bind(controller));

export default TankRouter;
