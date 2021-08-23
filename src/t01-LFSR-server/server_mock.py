import socketserver
from typing import Generator
import numpy as np

ADDRESS = 8008

SEED_SET = False

def init_random_generator(seed: bytes) -> Generator[bytes, None, None]:
    random_generator = np.random.default_rng(seed=int.from_bytes(seed, "big"))
    return random_generator # type: ignore
    
def get_random_number(rand_gen, n_gen: int) -> bytes:
    print(n_gen)
    n_gen = min(n_gen, 1024)
    rand_int = rand_gen.integers(0, 0b1<<32, dtype=np.uint32, size=n_gen)
    return rand_int.tobytes() # type: ignore

class RandomRequestHandler(socketserver.BaseRequestHandler):
    def init_random_generator(self, seed):
        self.server.random_gen = init_random_generator(seed)

    def handle(self):
        # Echo the back to the client
        data = self.request.recv(4)
        print(f"recv {data}")
        data_snd = b""
        if(not hasattr(self.server, "random_gen")):
            self.init_random_generator(data)
            print("init")
        else:
            data_snd = get_random_number(self.server.random_gen, int.from_bytes(data, "little"))
        print(f"snd {len(data_snd)} bytes")
        self.request.send(data_snd)

if __name__ == "__main__":
    address = ('localhost', ADDRESS)
    with socketserver.TCPServer(address, RandomRequestHandler) as server:
        print(server)
        server.serve_forever()

