# Dockerfile for trident

# Use pytorch image as base
FROM python:3.13-slim-bookworm

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

WORKDIR /app

# Install dependencies
RUN --mount=type=cache,target=/root/.cache/uv \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    uv sync --locked --no-install-project

# Copy the application code
ADD . /app
RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --locked

# Activate the virtual environment
ENV PATH="/app/.venv/bin:$PATH"

# Add tool bin directory to PATH
ENV PATH="/root/.local/bin:$PATH"
