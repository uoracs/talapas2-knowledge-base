---
layout: default
title: Class PIRG
nav_order: 1
parent: PIRGs
---

# Class PIRG

## Request

To request a class PIRG on Talapas send an email to [racs@uoregon.edu](mailto:racs@uoregon.edu "mailto:racs@uoregon.edu")

Include the following information:

- PIRG name - usually the class name, e.g. erth363
- PIRG PI - instructor of the class and responsible for student compute activity and storage costs
- PIRG members - provide an export of the class roster from Canvas including StudentDuckID, StudentFirstName, StudentLastName (95# is not necessary)
- Storage requirements - 2TB is the default capacity provisioned but more can be given upon request.
- Billing index - invoices are emailed monthly providing a summary usage in the PIRG compute (SU) and storage consumption. Note: charge back is suspended until further notice

## Reservations

slurm reservations sets aside resources on the cluster for use only by the class and at a specified time. They can be useful during:

- lecture for live coding examples where students follow along
- lab when students have a dedicated time to work together

Reservations typically allocate 1-3 compute nodes from the short partition and students to request resources within the scope of the reservation, e.g. 1 core and 4GB memory.

The naming convention is PIRG-day, for example erth363-mon would be the name of the reservation for the class PIRG erth363 that meets on Monday’s.

To use a reservation in Open OnDemand (OOD), specify the reservation name and partition name where the nodes allocated to the reservation reside (default is short) in the corresponding text fields. With `srun` or `sbatch` include `--reservation=erth363` and `--partition=short`.

### Reservation Behaviors worth noting

1. Jobs that do not specify the correct partition containing the allocated nodes in the reservation will queue (PD) until killed when the reservation ends or are deleted by the user
2. Jobs submitted to the reservation before the StartTime will fail with a clear message in OOD, “requested reservation is invalid”
3. Jobs requesting more cores than the reservation provides fail with a clear error message in OOD
4. Jobs requesting  more memory than the reservation provides will queue (PD) until killed when the reservation ends or deleted by the user
    1. Other jobs requesting memory available in the reservation will launch successfully
5. Jobs are launched successfully even when requesting more time than reservation duration
6. Jobs are killed once the reservation ends

 Behaviors 1 and 4 are troublesome in OOD because the pending reason code isn’t displayed. In a terminal, `squeue` will report the job status in the queue.

## Student support

We ask that only the instructor or the TA open tickets within the RACS support portal. This helps group similar issues together and reduce potentially redundant tickets in the system. We also don’t want to inadvertently contribute to an assignment solution by answering a support ticket opened by a student.

## Student data

Data on Talapas does not have a backup copy. Student data is retained for 90 days after the end of the term unless notified otherwise.
