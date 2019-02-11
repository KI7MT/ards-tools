using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.NetCore.Adif.Domain.Models;

namespace Ards.NetCore.Adif.Api.Controllers
{
    [Route("api/QsoUploadStatus")]
    [ApiController]
    public class QsoUploadStatusController : ControllerBase
    {
        private readonly AdifContext _context;

        public QsoUploadStatusController(AdifContext context)
        {
            _context = context;
        }

        // GET: api/QsoUploadStatus
        [HttpGet]
        public async Task<ActionResult<IEnumerable<QsoUploadStatus>>> GetQsoUploadStatus()
        {
            return await _context.QsoUploadStatus.ToListAsync();
        }

        // GET: api/QsoUploadStatus/5
        [HttpGet("{id}")]
        public async Task<ActionResult<QsoUploadStatus>> GetQsoUploadStatus(int id)
        {
            var qsoUploadStatus = await _context.QsoUploadStatus.FindAsync(id);

            if (qsoUploadStatus == null)
            {
                return NotFound();
            }

            return qsoUploadStatus;
        }

        // PUT: api/QsoUploadStatus/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutQsoUploadStatus(int id, QsoUploadStatus qsoUploadStatus)
        {
            if (id != qsoUploadStatus.Id)
            {
                return BadRequest();
            }

            _context.Entry(qsoUploadStatus).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!QsoUploadStatusExists(id))
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

        // POST: api/QsoUploadStatus
        [HttpPost]
        public async Task<ActionResult<QsoUploadStatus>> PostQsoUploadStatus(QsoUploadStatus qsoUploadStatus)
        {
            _context.QsoUploadStatus.Add(qsoUploadStatus);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetQsoUploadStatus", new { id = qsoUploadStatus.Id }, qsoUploadStatus);
        }

        // DELETE: api/QsoUploadStatus/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<QsoUploadStatus>> DeleteQsoUploadStatus(int id)
        {
            var qsoUploadStatus = await _context.QsoUploadStatus.FindAsync(id);
            if (qsoUploadStatus == null)
            {
                return NotFound();
            }

            _context.QsoUploadStatus.Remove(qsoUploadStatus);
            await _context.SaveChangesAsync();

            return qsoUploadStatus;
        }

        private bool QsoUploadStatusExists(int id)
        {
            return _context.QsoUploadStatus.Any(e => e.Id == id);
        }
    }
}
