using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.Tools.Domain.Adif.Adif.Models;

namespace Ards.Tools.Adif.Api.Controllers
{
    [Route("api/Contest")]
    [ApiController]
    public class ContestController : ControllerBase
    {
        private readonly AdifDomainContext _context;

        public ContestController(AdifDomainContext context)
        {
            _context = context;
        }

        // GET: api/Contest
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Contest>>> GetContest()
        {
            return await _context.Contest.ToListAsync();
        }

        // GET: api/Contest/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Contest>> GetContest(int id)
        {
            var contest = await _context.Contest.FindAsync(id);

            if (contest == null)
            {
                return NotFound();
            }

            return contest;
        }

        // PUT: api/Contest/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutContest(int id, Contest contest)
        {
            if (id != contest.Id)
            {
                return BadRequest();
            }

            _context.Entry(contest).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ContestExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/Contest
        [HttpPost]
        public async Task<ActionResult<Contest>> PostContest(Contest contest)
        {
            _context.Contest.Add(contest);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetContest", new { id = contest.Id }, contest);
        }

        // DELETE: api/Contest/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<Contest>> DeleteContest(int id)
        {
            var contest = await _context.Contest.FindAsync(id);
            if (contest == null)
            {
                return NotFound();
            }

            _context.Contest.Remove(contest);
            await _context.SaveChangesAsync();

            return contest;
        }

        private bool ContestExists(int id)
        {
            return _context.Contest.Any(e => e.Id == id);
        }
    }
}
