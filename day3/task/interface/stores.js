import { writable } from "svelte/store"

export const view = writable({
  home: 1,
  current: 1,
})

export const proposaltoVote = writable({
  proposalID: "null",
})

export const hasvoted = writable(false)

export const principal = writable(null)
export const daoActor = writable(null)
