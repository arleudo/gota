import express from "express";
import UserRouter from "./UserRouter";
import TankRouter from "./TankRouter";

const router = express.Router();

router.use("/user", UserRouter);
router.use("/tank", TankRouter);

export default router;
