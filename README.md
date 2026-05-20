# Agent-Hooks

Agent-Hooks owns webhook, external interruption, extension, and human-in-the-loop callback contracts for AGenNext.

## Decision

Agent-Hooks is the event ingress and extension layer for agents and the platform.

Agent-Platform consumes hook events and decides what action to take.

## Scope

Agent-Hooks owns:

- webhook contracts
- external interruption events
- extension callback contracts
- HITL callback contracts
- approval callback payloads
- pause/resume hooks
- cancellation hooks
- escalation hooks
- external system event adapters
- hook verification requirements

Agent-Hooks does not own:

- final platform decisions
- runtime execution
- identity verification
- deployment execution
- long-term state ownership

## Boundary

| Component | Responsibility |
|---|---|
| Agent-Hooks | Webhook and external callback contracts |
| Agent-Platform | Final decision and orchestration authority |
| Agent-Runtime | Executes pause/resume/cancel/continue decisions |
| Agent-Identity | Verifies hook sender identity when needed |
| Agent-IGA | Governs whether hook action is allowed |
| Agent-Traces | Records hook events and decisions |
| Agent-Chat | User-facing HITL prompts |
| Agent-Dashboard | Operator-facing HITL prompts |

## Hook types

```txt
hook.hitl.approval_requested
hook.hitl.approval_granted
hook.hitl.approval_rejected
hook.runtime.pause_requested
hook.runtime.resume_requested
hook.runtime.cancel_requested
hook.external.incident_detected
hook.external.policy_changed
hook.external.deployment_window_opened
hook.external.deployment_window_closed
```

## Flow

```txt
External system or human sends hook
  ↓
Agent-Hooks validates payload shape
  ↓
Agent-Identity verifies sender if required
  ↓
Agent-IGA checks permission if required
  ↓
Agent-Platform decides action
  ↓
Agent-Runtime executes approved change
  ↓
Agent-Traces records hook lifecycle
```

## Rule

Hooks can interrupt or extend execution.

Hooks cannot bypass Platform authority.
