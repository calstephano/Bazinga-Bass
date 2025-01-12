import asyncio
import logging
from src.python import wake_word_detected

logging.basicConfig(level=logging.INFO)

if __name__ == "__main__":
    """Entry point for Big Mouth Bazinga Bass."""
    logging.info("Starting Big Mouth Bazinga Bass...")
    try:
        asyncio.run(wake_word_detected())
    except KeyboardInterrupt:
        logging.info("Program interrupted. Shutting down gracefully...")
    except Exception as e:
        logging.error(f"An unexpected error occurred: {e}")
