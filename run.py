import asyncio
import logging
from src.python import wait_for_wake

logging.basicConfig(level=logging.INFO)

if __name__ == "__main__":
    """Entry point for Big Mouth Bazinga Bass."""
    logging.info("Starting Big Mouth Bazinga Bass...")
    try:
        asyncio.run(wait_for_wake())
    except Exception as e:
        logging.error(f"An unexpected error occurred: {e}")
