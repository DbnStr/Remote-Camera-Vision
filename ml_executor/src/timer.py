import asyncio


class Timer:
    def __init__(self, interval, callback):
        self.handler = None
        self.interval = interval
        self.callback = callback
        self.loop = asyncio.get_event_loop()

        self.is_active = False

    def start(self, loop=None):
        self.is_active = True
        if loop is not None:
            self.loop = loop
        self.handler = self.loop.call_later(self.interval, self._run)

    def _run(self):
        if self.is_active:
            self.callback()
            self.handler = self.loop.call_later(self.interval, self._run)

    def stop(self):
        self.is_active = False
        if self.handler is not None:
            self.handler.cancel()
