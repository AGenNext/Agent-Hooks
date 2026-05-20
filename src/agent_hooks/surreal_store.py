from surrealdb import Surreal


class SurrealHookStore:
    def __init__(
        self,
        url: str,
        namespace: str,
        database: str,
        username: str,
        password: str,
    ):
        self.db = Surreal(url)
        self.namespace = namespace
        self.database = database
        self.username = username
        self.password = password

    async def connect(self):
        await self.db.signin({
            "username": self.username,
            "password": self.password,
        })

        await self.db.use(self.namespace, self.database)

    async def create_hook_event(self, event_id: str, payload: dict):
        return await self.db.create(
            f"hook_event:{event_id}",
            payload,
        )

    async def get_hook_event(self, event_id: str):
        return await self.db.select(f"hook_event:{event_id}")

    async def update_hook_status(self, event_id: str, status: str):
        return await self.db.merge(
            f"hook_event:{event_id}",
            {
                "status": status,
            },
        )
