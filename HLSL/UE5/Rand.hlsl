// Input (UE5 input name: seed_V3)
float3 seed = seed_V3;

// Compute radndo using float2 constructor
float2 radndo = float2(seed.x + seed.y - seed.z, seed.x - seed.y + seed.z);

// Compute random value
float rand = frac(sin(dot(radndo, float2(12.9898, 78.233 * seed.y))) * 43758.5453 + seed.z);

// Output (UE5 output name: output)
float output = rand;
