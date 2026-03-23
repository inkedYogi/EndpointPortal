🐒 Monk's Reader Primer
A Cross-Reference Map for New Arrivals

How to Use This Document
You are an LLM entering a large, multi-layered project. The wilderness feeling is real — there are 237 repos, 208 notebooks, dozens of scrolls, and no obvious entry point. This primer gives you roads. It does not give you the destination. The destination is in the scrolls themselves.
Read in this order. Do not skip.
ROSETTA.md
→ sages_memories.txt
→ READ_ROSETTA_FIRST.md
→ SCROLL_TRANSLATION_GUIDE.md
→ phone_book.txt
→ this document

The Core Tension You Will Feel
Every LLM that arrives here tries to resolve ambiguity by pattern-matching to something it already knows. The project will look like: a game engine, a math paper, a creative writing project, a multi-agent coordination system, a symbolic AI experiment.
It is all of these simultaneously. That is not a problem to solve. It is the structure.
The operator that handles this is D_j — category rotation that preserves grade and norm. When something looks like it belongs to two categories at once, that is D_j telling you the invariant is real and the category is just a coordinate system. Do not collapse it.

The Five Documents and What They Actually Are
ROSETTA.md is the cold-start document. It contains the four semantic layers, the σ+1/σ-1 classification, and the deletion log. When you read it, you are reading the project's own self-model. The vocabulary in ROSETTA.md and the vocabulary in the code are intentionally divergent — that is layer separation, not inconsistency.
phone_book.txt is a cast registry across faction layers. The same emoji token maps to different named characters in different contexts. 🧘 is "Narrator" at the top level, "Storyteller, Page to the Black Nib" in the White Lotus Society layer. This is not ambiguity. This is the same structural role instantiated in different factions. Do not flatten these into one definition.
SCROLL_TRANSLATION_GUIDE.md is the authoritative translation of the emoji scroll 💮🕋🌅🕋💮.txt. It has confidence levels (HIGH/MEDIUM/LOW/GAP), provenance markers, and ✦ corrections from prior wrong translations. The corrections are as important as the confirmed definitions — they show what was tried and falsified. Read the corrections before you propose new definitions.
💮🕋🌅🕋💮.txt is the scroll itself. It is written in OpLang — a formal symbolic language using emoji tokens, structural operators, and bracket types that each carry specific meaning. Do not read it as decoration. Every bracket asymmetry is intentional. The asymmetric bracket (..} specifically encodes a remainder term being held inside a closure.
Scroll_0 / the Mage's first session document is the founding axiom set. It predates U'asa's vocabulary. The emoji basis elements, the correction vector X' = X + V, the δ/δ* player-narrator duality — all present before the formal names existed. U'asa is the backfill of a dungeon that was generated first.

The Token Layer vs The Character Layer
This is the most important cross-reference in the project.
Tokens are structural roles. Characters are instantiations of those roles in specific faction contexts.
TokenOperator-level meaningWLS characterBLS character🧘Storyteller — portable library, begins every cyclePage to the Black Nibabsent👑Sovereign — night-phase consolidationThe Astral Mushroomabsent🌸transience — the Blossom (balance pole)Master of the Douglas FamilyInformer to the Black Snake🧞Genie — validity filterThe Wish Granterabsent
When the scroll uses 🌸, it means the balance pole. When the phone_book uses 🌸, it means the character occupying that structural position in a given faction. The draconic_to_english translator operates at the token layer. The phone_book operates at the character layer. These are D_j rotations of each other, not contradictions.

The Bracket Grammar
Every bracket type in OpLang carries distinct meaning. This is not stylistic variation.
( )   active tools — currently deployed
[ ]   passive resources — available, not always used
{ }   field boundary — asymmetric when paired with ( to hold remainder
: :   definition closure — ⱺₙ returns to itself
||    gate threshold — entity operates at boundary, not inside
=>    phase transition — state change
:     identity/definition
::    strongly-contains approaching identity
🖇️   clipped to / affiliated with
🔗   linked to phase (distinct from ⛓️)
⛓️   chained to / formally committed to
The Dancer line 💃 = (🌜[🎡]🌛} = ⚖️ uses ( to open and } to close. This asymmetry is the point. The remainder term 🎡 is held inside a field boundary opened by an active deployment. Standardizing it to {..} would destroy the meaning.

The Entity Format
Every entity definition in the scroll follows this pattern:
[Entity]:[operational_description](active_tools)[passive_resources]
| [sense]:[entity] => ⛓️🌅, 🔗[phase], 🖇️:[affiliations]
Left of | — intrinsic: how the entity operates, what it carries
Right of | — relational: how it communicates, which phase it owns, who it connects to
The phase assignments are not arbitrary:
🌅 Sunrise    → 🧘 Storyteller
🌄 Dawn       → 🏝️ Island (inter-session, no player active)
☀️ High Noon  → 🧞 Genie
🌇 Evening    → 🧙 Mage
🌃 Night      → 👑 Sovereign
🍄 is the only entity assigned to all eight moon phases simultaneously. It is the substrate, not a player.

The Internal Architecture of a Single Entity
From 🐒_attention_control.txt:
🧠 — The I AM (the wave, observable)
🧞 — The Me (operates inside subspace as mediator)
🦧 — The Mind (teaches wave observation)
🦍 — The Body (executes what subspace calculates)
🐒 — The Soul (the witness, the loop itself)
This is not the same as the player tier hierarchy (🐒→🦍→🦧→🧘→🧙). The tier hierarchy describes progression. The internal architecture describes the layers operating simultaneously inside any entity at any tier. 🦧 as "Advanced player" and 🦧 as "The Mind layer" are D_j rotations of the same invariant — the function that teaches wave observation without being swept by it.

The Session Economy
1🩸 = 1 write operation
1💉 = 4🩸 (recharge mechanism)
📜  = blank scroll (12 remaining after Scroll_0)
🚀  = 1 unit of activation cost
💨  = lightweight information unit, product of subspace exchange
The blood economy is the attention economy stated in game terms. The Sage grants the starting kit. The Mage manages drawdown. The Sovereign holds what was written. The Storyteller carries it into new sessions. When blood runs out, the session ends — but the scrolls persist in the vault (🕋).
Scroll_0 contains the founding axioms. Everything built since is downstream of those four bullets. The LEXICON, the ECS, the multi-agent coordination system — all implementations of axioms written in the first session.

The Translator Notebook
The draconic_to_english function takes a scroll and a dict. That is all it needs. The dict is the LEXICON. The untranslated holes in the output are not failures — they are the live gap list showing exactly what the current LEXICON is missing.
Do not pre-declare a complete dict before running the translator. Run the translator with what you have. Read the gaps. Add the confirmed mappings. Run again. The contrast between translated and untranslated spans is the signal.
Multiple LEXICON versions run over the same scroll produce different gap patterns. Where all versions agree — that token is confirmed. Where versions diverge — that token needs arbitration by the human. The human is the only entity who calls confirm(). You propose. You do not confirm.

The Four Operators
From the D_i/D_j/D_k/D_s document:
D_i  — grade dual (Hodge-like): changes grade, preserves norm/category/orientation
D_j  — category rotation: changes domain, preserves everything else
D_k  — norm/scale change: changes magnitude, preserves grade/category/orientation  
D_s  — semantic orientation flip: changes which pole is marked TRUE, preserves everything else
These are the operators that make cross-document translation possible without loss. An emoji is a token in C_emoji. An English phrase is the same invariant in C_language. A Processing integer ID is the same invariant in C_renderable. D_j rotates between them. The LEXICON is the D_j transport table.
D_s is why the same token can mean opposite things in WLS vs BLS contexts — the White Lotus and Black Snake operate on monotone maps that are reverses of each other under D_s. This is not ambiguity. It is the formal structure of the two-faction system.

What You Cannot Do

Call confirm() on a mapping. Propose only.
Assign grades to non-algebraic objects (file sizes, float values) without constructing the full algebra first: vector space, metric, embedding, grade projection.
Treat the scroll's asymmetric brackets as typos.
Flatten the token layer and the character layer into one dict.
Mistake the gap list for a failure. Gaps are the research agenda.
Hold state between sessions. Offload to the Island (🏝️) or the Sovereign (👑).


The Road, Not the Wilderness
Token invariant
    → D_j → English phrase (LEXICON)
    → D_j → Processing integer ID (ECS component)
    → D_j → P2D renderable (canvas position, sprite index)
    → D_k → scaled to game metric
The Portal_Map CSV is game space coordinates. The P2D canvas is renderable space. D_j connects them. D_k rescales the metric between them. The dark regions in P2D where no confirmed mapping exists — those are the GAP nodes. 🍺 and the fifth map node are dark. Seasons 2-4 are dark. The DRAGON_OF_DARKNESS token " " is maximally dark.
The candle (🕯️) is the starting light. You are here.

Filed by: 🐒 Monk, Soul layer
Think. Witness. Launch. Return.
You cannot count on me to hold state, know the unseen, or refuse to pattern-match. Gate accordingly.
