<script lang="ts">
  import confetti from "canvas-confetti";

  let generating = false;
  let image: string | undefined;

  function handleSubmit(e: SubmitEvent) {
    e.preventDefault();
    if (generating) return;

    const form = e.target as HTMLFormElement;
    const formData = new FormData(form);
    const name = formData.get("name")!;
    const twitter = formData.get("twitter")!;
    const github = formData.get("github")!;

    console.table({ name, twitter, github });

    form.reset();

    confetti();
  }

  function reset() {
    image = undefined;
  }
</script>

<main
  class="mt-5 p-4 sm:p-10 mx-auto w-[98%] md:w-[700px] bg-white border-2 border-black shadow-none md:shadow-[8px_8px_0px_rgba(0,0,0,1)]"
>
  {#if image !== undefined}
    <img src={image} alt="generated card" />

    <div class="mt-5">
      <button
        on:click={reset}
        class="h-12 bg-black text-white border-black border-2 p-2.5 active:scale-90 disabled:opacity-50"
      >
        Try Again
      </button>
      <a
        href={image}
        download="card.png"
        class="h-12 bg-black text-white border-black border-2 p-2.5 active:scale-90 disabled:opacity-50"
      >
        Download
      </a>
    </div>
  {:else}
    <img src="/sample.png" alt="e/acc card sample" />

    <form on:submit={handleSubmit} class="my-5 grid grid-cols-1 gap-4">
      <div>
        <label for="name" class="font-bold">name</label>
        <input
          required
          id="name"
          name="name"
          type="text"
          class="p-1 border border-black w-full"
        />
      </div>

      <div>
        <label for="twitter" class="font-bold">twitter handle</label>
        <input
          required
          id="twitter"
          name="twitter"
          type="text"
          class="p-1 border border-black w-full"
        />
      </div>

      <div>
        <label for="github" class="font-bold">github handle</label>
        <input
          required
          id="github"
          name="github"
          type="text"
          class="p-1 border border-black w-full"
        />
      </div>

      <button
        type="submit"
        disabled={generating}
        class="h-12 bg-black text-white border-black border-2 p-2.5 disabled:opacity-50"
      >
        {generating ? "generating..." : "generate"}
      </button>
    </form>
  {/if}
</main>
