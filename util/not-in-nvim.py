import os
import openai
import random

openai.organization = "org-clb7fC6MOXdiiTsuL2gxtU5t"
openai.api_key = os.getenv("OPENAI_API_KEY")

filename = os.path.join(os.path.dirname(__file__), "responses.cache")
caricatures = os.path.join(os.path.dirname(__file__), "caricatures.list")

max_cache_size = 50
cache_file = open(filename)
contents = cache_file.readlines()
current_size = len(contents)
idx = random.randrange(0, max_cache_size + 1)

# print(f"%s : %s [choice: %s]" % (max_cache_size, current_size, idx))

if idx > current_size - 1:
    cache_file.close() # we no longer need to read from cache, close it.
    caricature = random.choice(open(caricatures).readlines())
    # ask gpt
    prompt = f"Pretend that you are %s - be funny and warn me that the command I entered wont work since I'm in my terminal and not in nvim anymore. Don't use any newline characters." % caricature
    completion = openai.ChatCompletion.create(model="gpt-3.5-turbo", messages=[{"role": "user", "content": prompt}])
    response = completion.choices[0].message.content
    # cache
    cache = open(filename, "a") # append mode
    cache.writelines(response + "\n")
    cache.close()
    print(response) #output 
else:
    print(contents[idx - 1])
    cache_file.close() # we no longer need to read from cache, close it.

